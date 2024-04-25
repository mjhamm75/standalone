import { reorderLoadedData } from "@/server/utils/reorder-loaded-data";
import DataLoader from "dataloader";

export class CompanyService {
  private _companiesLoader?: DataLoader<string, Company | null>;

  companiesLoader() {
    if (!this._companiesLoader) {
      this._companiesLoader = new DataLoader(async (ids: readonly string[]) => {
        const matches = await prisma.company.findMany({
          where: {
            id: {
              in: ids as string[],
            },
          },
        });

        return reorderLoadedData(ids, matches);
      });
    }

    return this._companiesLoader;
  }

  //   async searchCompanies({ limit, offset, email, keywords }: SearchUsersRequest) {
  //     const where = {
  //       ...(keywords && {
  //         OR: [
  //           {
  //             email: {
  //               search: keywords,
  //             },
  //           },
  //           {
  //             name: {
  //               search: keywords,
  //             },
  //           },
  //           {
  //             penName: {
  //               search: keywords,
  //             },
  //           },
  //         ],
  //       }),
  //       ...(email ? { email } : null),
  //     };

  //     // TODO => thist should be raw sql so we can search with similarity for fuzze searching
  //     const users = await prisma.user.findMany({
  //       take: limit,
  //       skip: offset,
  //       where,
  //     });

  //     const totalCount = await prisma.user.count({
  //       where,
  //     });

  //     return {
  //       results: users,
  //       total: totalCount,
  //     };
  //   }

  //   async searchUsersConnections(args: SearchUserssParams) {
  //     const { first, after, last, before, ...filters } = args;
  //     const { limit, offset } = connectionUtils.parseArgs({
  //       first,
  //       after,
  //       last,
  //       before,
  //     });

  //     const response = await this.searchUsers({
  //       ...filters,
  //       limit,
  //       offset,
  //     });

  //     return connectionUtils.createConnection<User>({
  //       total: response.total,
  //       nodes: response.results,
  //       offset,
  //     });
  //   }
}
